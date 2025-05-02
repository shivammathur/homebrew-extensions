# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT82 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.6.0.tgz"
  sha256 "7c5eaa693e49f43962fa8afa863c51000dc620048dcf9442453c27ca151e291e"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "403f84fd1e0271fce8fad7ff9002913d946f043544401562392ed88139fc5b38"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "1bc3ca766ca9a32f4ca0ace8b2f6e68629d56af6273bbe3d3fcb649c7b52c604"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "0499082a862d0265f42ef9d2b036e3b1f7dbc41565cc1996d202ab9a60a53675"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "955ff72f02333085adbce4ab367c7d80ad6d951850de49ea2dfc6a8f66adbc52"
    sha256 cellar: :any_skip_relocation, ventura:        "c242d65a6d4ae0ac174b63a205434ef612468b40d0e61adf7ee3d6c1a4ae9ffb"
    sha256 cellar: :any_skip_relocation, monterey:       "e25ac8869b188a33a5b1116e33109b01ab4547b5bd7459331af4f7ae77f1b910"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e5a7dc243188a97813c9ec0c0fa06b11f358374de23546448549192792b62023"
  end

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
