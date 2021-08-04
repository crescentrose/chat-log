module MessagesHelper
  def team_color(team_name, message)
    content_tag :span, message, class: "team-colored team-#{team_name.downcase}"
  end

  # The following method contains code extracted and modified from the Steam
  # Condenser project:
  # https://github.com/koraktor/steam-condenser-ruby/blob/master/LICENSE
  #
  # Copyright (c) 2008-2015, Sebastian Staudt
  # All rights reserved.
  #
  # Redistribution and use in source and binary forms, with or without modification,
  # are permitted provided that the following conditions are met:
  #
  # * Redistributions of source code must retain the above copyright notice,
  #   this list of conditions and the following disclaimer.
  # * Redistributions in binary form must reproduce the above copyright notice,
  #   this list of conditions and the following disclaimer in the documentation
  #   and/or other materials provided with the distribution.
  # * Neither the name of the author nor the names of its contributors
  #   may be used to endorse or promote products derived from this software
  #   without specific prior written permission.
  #
  # THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  # ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  # WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  # DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
  # ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  # (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  # LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
  # ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  # (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  # SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  def community_id(steam_id3)
    if steam_id3 =~ /^\[U:([0-1]:[0-9]+)\]$/
      steam_id3 = $1.split(':').map { |s| s.to_i }
      community_id = steam_id3[0] + steam_id3[1] + 76561197960265727
    else
      raise ArgumentError, 'bad steamid format ' + steam_id3
    end

    community_id
  end
  # End of method containing code extracted and modified from the Steam
  # Condenser project

  def steam_url(steam_id3)
    "https://steamcommunity.com/profiles/#{community_id(steam_id3)}"
  end
end
