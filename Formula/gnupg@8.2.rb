# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT82 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.1.tgz"
  sha256 "a9906f465ab2343cb2f3127ee209c72760238745c34878d9bbc1576486219252"
  head "https://github.com/php-gnupg/php-gnupg.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia:  "153ae630364c534e57c8eb3faa2a619e8582bcfabf4e3a60b8d3314f65e1681f"
    sha256 cellar: :any,                 arm64_ventura:  "23db356556cb20acdcd7e3e05ffeae393ff2649a80cb5270fe72102f9899e038"
    sha256 cellar: :any,                 arm64_monterey: "be5184ee59c71b2c682b70b8eac14c9da337cc064a3312e2f128a21cd2d6d817"
    sha256 cellar: :any,                 arm64_big_sur:  "3237337f33d23cbaff0cbf28a1f65a15cefebf6c5f702248ae0b86b7bffffe97"
    sha256 cellar: :any,                 ventura:        "9954aee85ab26b7566d37e8b198b1b573a8b436a61af0ff5da0e3b00234c77fe"
    sha256 cellar: :any,                 monterey:       "4d54504497ea855366cf1d864e0f293c8b7b11b6842270f351bdc9e4fcd052be"
    sha256 cellar: :any,                 big_sur:        "4dd8a169f40032735f58b0a6a0979cc4bb3b6aee9fba3a2a0136d8f1e29f95de"
    sha256 cellar: :any,                 catalina:       "b799646a353b84065f1b8a42097c8ad85a94248e764cc61dfc3883a40f758ea7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "df59c12e2ab5a62bed558ceae4b2a9c9aa3c1cccc09b212634453212c1720dee"
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
