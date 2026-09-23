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
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "056833bb5ca2706d59a0b70a4d3c40987670b60015343505a07a8fdd529e1497"
    sha256 cellar: :any, arm64_tahoe:       "cdfe2397ddb72c1f7985ab38206a66e564131c87ce22d17f1dbe0bfc6019de7c"
    sha256 cellar: :any, arm64_sequoia:     "2eda1f102424178bbd3a84df9c838113eff5c6de386f55590cdce51461b1eaf3"
    sha256 cellar: :any, arm64_linux:       "38eece82aa89bf2587b42c108afa94019a05d2c111882ec1630451894369eefb"
    sha256 cellar: :any, x86_64_linux:      "c8ced2b93cbb65935293b0f89e544ade5e25c0651316e41854556967a6d223bc"
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
