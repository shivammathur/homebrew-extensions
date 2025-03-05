# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT84 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.1.tgz"
  sha256 "a9906f465ab2343cb2f3127ee209c72760238745c34878d9bbc1576486219252"
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "6085327957a41fa8c5eed2688e764f97b12f26f6e098429dd503f1df91437c9d"
    sha256 cellar: :any,                 arm64_sonoma:  "7cca8461dee594c5331b53ca9f05824a44cc140a9f2aaa504d20c61153d7f216"
    sha256 cellar: :any,                 arm64_ventura: "a317eaf25a2e80929f1d566cec29be2717d752f7d96778ab6f6a93c4360cff20"
    sha256 cellar: :any,                 ventura:       "78fc98bf7d8f4a095bed5007543e0cf8d1166c0c8e5afcda0818064defe0f43b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b781ac7d0048df74ef7d2ea4eca5c69cf56eb7211593b6cf371aa26c67ef7e75"
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
