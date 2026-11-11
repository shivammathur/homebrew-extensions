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
  revision 1
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "5e20224a87aae4cb5b6e9f031e5f71c4f2954b732da1cc82576e3d513c5afadd"
    sha256 cellar: :any, arm64_tahoe:       "5a41696b37f28de44d5500c8868b58c2473faf37d64b7a3d883e03775140ea44"
    sha256 cellar: :any, arm64_sequoia:     "2f7f118326c173983825b6505f35910ff65b547a2b11efe71f30d92f4a4a5ed3"
    sha256 cellar: :any, arm64_linux:       "e7030f2c376a70df85beec1575a10e1da167589169c5fb44195f90568ebf3185"
    sha256 cellar: :any, x86_64_linux:      "af5c0e7dbddc3d8d4de1adf601e44fc4ba88e725b2c390eb748b62659fd1ca4d"
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
