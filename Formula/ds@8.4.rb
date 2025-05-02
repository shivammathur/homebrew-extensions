# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT84 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.6.0.tgz"
  sha256 "7c5eaa693e49f43962fa8afa863c51000dc620048dcf9442453c27ca151e291e"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a08b43ad4b7f80382950e415c08d284ecf69fcf60e635a201905aa5ef1c815f4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d4b806984e8007b48e50b50fbcde17a46ddcbb4abd1561e6863c11788c325c64"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a26027ff886d0db56ec2500e6ae7ebf91566ee2e6a65dd481f9d42bfec43eec3"
    sha256 cellar: :any_skip_relocation, ventura:       "a9b81c12b80727a6f31942a0c8bdd9c151a7847ae1344ec4a9e429d11fd12103"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2b0d3d5c0019b8172aecbaf0683832d658987f4ee06c523d512501d733e567aa"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    inreplace "src/common.h", "fast_add_function", "add_function"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
