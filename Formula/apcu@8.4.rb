# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT84 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.25.tgz"
  sha256 "c4e7bae1cc2b9f68857889c022c7ea8cbc38b830c07273a2226cc44dc6de3048"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3f71fb8473cf5e0d8a5e4220544847642eaf78f7fb5c456b54ff67555c257618"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9ddafda2108fdd9dc1c95bb209f05e802154863ba1ec0ea40ed05b441c6df62a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f40de350c4a8d589f3fc1c0558e63525bd8aa33e5b616686a92214c8649e3830"
    sha256 cellar: :any_skip_relocation, ventura:       "953e0b23ae7c4400bed075838339f13af66d1d44a2e28bdae72cd905c21f9b45"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b2cb0cc4bab9f0a819bf2c9419edcb39222394ce1a0eace6b2c60bf4f1740e61"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "09f1f627adb64d0620d8c88c7df9ab55a846b4c025241ee1528991b9786b340c"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
