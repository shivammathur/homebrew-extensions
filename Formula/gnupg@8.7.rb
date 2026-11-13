# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT87 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.4.tgz"
  sha256 "4d4a0980759bf259e4129ef02cb592bbeb103b4005e7b4bb6945d79488951a50"
  revision 2
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "cac1d0747ced37cb2ce0eb57fda84ad5c7ed8ecae942230eba62e53b4c22400f"
    sha256 cellar: :any, arm64_tahoe:       "b77494bbcafdf3cf7ca380b3b1855e36d0325c8be27917b7872053f32c7589d2"
    sha256 cellar: :any, arm64_sequoia:     "6e8ea0535cf4272936e84115b634a313a1bb203770a8823fc00638182df84c19"
    sha256 cellar: :any, arm64_linux:       "a697bcd5915b2b328e984405a1bf5b7bf4c643532149c60ebb0656974b94b4cd"
    sha256 cellar: :any, x86_64_linux:      "e2ef5eaa8c661451e9d9da833e16ab4fb07f7b001b66a48b8d776f741541ad1c"
  end

  depends_on "gpgme"

  def install
    args = %W[
      --with-gnupg=#{Utils::Path.formula_opt_prefix("gpgme")}
    ]
    Dir.chdir "gnupg-#{version}"
    inreplace "phpc/phpc.h", "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
