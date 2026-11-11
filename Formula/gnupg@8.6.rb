# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT86 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "57f3a40f9b7e265e3f0d552f73f9563aea77bbd7f5912ba8e043a4428310ad78"
    sha256 cellar: :any, arm64_tahoe:       "d896b8b6e3bd30006f6f17c0801bf96e6484a6e8e3a85fc22553eda0203ff971"
    sha256 cellar: :any, arm64_sequoia:     "bfc322207b2b465663ef152cc347b0711feec0c871fd35ce18bdd510f47228ee"
    sha256 cellar: :any, arm64_linux:       "344bd4b345f555381ddcb43990664ca9486aba4572c35e78a75838f9cd69c64c"
    sha256 cellar: :any, x86_64_linux:      "4b2581100e15db645b79b3ec435f5ebe0e28479b85accb716fa26db8a8387404"
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
