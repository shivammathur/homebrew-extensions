# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT84 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.19.0.tgz"
  sha256 "27d406ba894015352e305c8b557812ffd70b3899b6a519ab874c99e42675cd3a"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "d87e40d8a9ebe1374d4d60027a10f17633da79a49af5aedcf8628fb2db60f6ec"
    sha256 cellar: :any, arm64_sequoia: "4100caa67a0298f1f22d897f3f674f85cd47dca1d3939fc4d207b77033bef421"
    sha256 cellar: :any, arm64_sonoma:  "0b1c60dd00c767f1647ffa4ba486fc603801f8d94dbc7efd542d67947190fa60"
    sha256 cellar: :any, sonoma:        "04e2d1afac887d968775cfef9d541d7c0993b2047db03f27e79511fd3849c7c5"
    sha256 cellar: :any, arm64_linux:   "cae2c1beeb3e595135a63f8c08c7b04b20ba15265777d0b269cc3ab646e6abad"
    sha256 cellar: :any, x86_64_linux:  "fdceea33ffd7fed90c7c153cc33f067b5f7068198b41f60059cbe17b19f5297b"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Utils::Path.formula_opt_prefix("brotli")}
    ]
    Dir.chdir "brotli-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
