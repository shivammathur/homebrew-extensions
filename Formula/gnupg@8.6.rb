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
  revision 1
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "730af65b03555799d4ee7dae4ce825015fc2f4f36f9b90a8d9f9d6b3ece32098"
    sha256 cellar: :any, arm64_tahoe:       "82690edd6cdeb269363d885a8705732d4f483436c84dab3a352647a278be22ba"
    sha256 cellar: :any, arm64_sequoia:     "9396fc2456365f255f1c7107d79b1c010955a0061e8d5533cf0f44e6459123c3"
    sha256 cellar: :any, arm64_linux:       "1e806380a704ddc068b2deb836726fdd08b150a42163f579ea29eeea24bbebb7"
    sha256 cellar: :any, x86_64_linux:      "0c5c90ebca798c8b8a322b13875a542e5b9a8200f06f5cafd5bc3a935759f1ad"
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
