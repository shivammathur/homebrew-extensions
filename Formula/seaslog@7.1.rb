# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Seaslog Extension
class SeaslogAT71 < AbstractPhpExtension
  init
  desc "Seaslog PHP extension"
  homepage "https://github.com/SeasX/SeasLog"
  url "https://pecl.php.net/get/SeasLog-2.2.0.tgz"
  sha256 "e40a1067075b1e0bcdfd5ff98647b9f83f502eb6b2a3d89e67b067704ea127da"
  head "https://github.com/SeasX/SeasLog.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/seaslog/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2265a0807aef8811a36141d2e89e9d3709a39f064b085d15b872a31863540e19"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "edb2d341074c56b1c042bedd21fdad1adc61fe1de24829468596f9302f6ffbe1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "21a6881f2de9b90dac204640fd70f066b79a6479672ed148311de562f0c5c8a1"
    sha256 cellar: :any_skip_relocation, sonoma:        "fade4a123e2b7a8dd017f3dfa81a00223e9005f905178b2ff01c1302da9d09a7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b25d8ac66e2c13ded4390b1e3ec732eb1e8829d1b5cbe8e0bc04e1ca43c68cdd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4100cbf194b5c648f6f5922edd9d8e70e18bc62acedf8372368bdcc94f0653eb"
  end

  def install
    Dir.chdir "SeasLog-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-seaslog"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
