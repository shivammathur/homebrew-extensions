# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "d22dd06e22dff4552d998dfaafc8ce9ec85ee215adc4897e2191c585c67ebca4"
    sha256 cellar: :any, arm64_sequoia: "d6f86fe047e6a29660c340a7cabb0cfc8a35c02d6d80e2a5c6f3e8fa21012f73"
    sha256 cellar: :any, arm64_sonoma:  "e074f41c575d185699edc6f2a4e32f8cf772bfa8faeea877501fde284d0ec301"
    sha256 cellar: :any, sonoma:        "13720b1d6e188bffa3349ef8cb9e2ef1a994cfb5ffb9776c5baf618dae0eee43"
    sha256 cellar: :any, arm64_linux:   "3c3cf60954ea2617a592c55caed026a4445f88baaf64109cd304dc76a9b85274"
    sha256 cellar: :any, x86_64_linux:  "896d03c6321ff987bfed840a8aeb67a3b9d934b5bc51845b9bc8baa0a55021ce"
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
