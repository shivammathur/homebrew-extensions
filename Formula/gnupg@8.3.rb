# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT83 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.3.tgz"
  sha256 "c1555e0c86a7f6d95141530761c1ecf3fe8dbf76e14727e6f885cd7e034bdfd2"
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "e559de5f559617a2ae2e73746cf57832c5dacd56c18db1972c6e0116343f2c31"
    sha256 cellar: :any,                 arm64_sonoma:  "930f33727348936170e6765f29ea1966fc9dae05a6197e37a1f88331138bb5ac"
    sha256 cellar: :any,                 arm64_ventura: "21e61605dcd463969af6c752c0c538ce78d3935be2a8f982a0463a942fdeacd8"
    sha256 cellar: :any,                 ventura:       "95d5a5e759268cf1df6766a35f7d80079604b4e44cd166ddb6044b7851d3af43"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d1977b8412e9cccce3bd80822cefafaf8456ec965de235ac9c945c43730ada0d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7aaac7b3bd45339dad8980cb6828869720541a42c52d71694f9446709ce01d23"
  end

  depends_on "gpgme"

  def install
    args = %W[
      --with-gnupg=#{Formula["gpgme"].opt_prefix}
    ]
    Dir.chdir "gnupg-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
