# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT86 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.18.3.tgz"
  sha256 "ed3879ec9858dd42edb34db864af5fb07139b256714eb86f8cf12b9a6221841a"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "817f16c174bbc7ab4d03848ce0a081b31eb7d81f5566afab92b83d2c37044661"
    sha256 cellar: :any,                 arm64_sequoia: "9e24fc30e60cbf27c5d00c559ef2bdd25dde32d67322cf44986cccd2ea55ade7"
    sha256 cellar: :any,                 arm64_sonoma:  "cdbeff790411c3f8067a1bbfe48c17cc633681558d9ee52861006c13b506af1f"
    sha256 cellar: :any,                 sonoma:        "178ab1b969de108ce9f431f9cff8a01559750a7568d1f8378b179479cabedd07"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "11c8600e6b9a21c7efb2eb4c9344bec476e9d764920d00daa0f41e42b0d17307"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "22b0b4700eef155d8e9cb5996ab6f14f47cfacb54776c02f4e2b6efe9f09c273"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Formula["brotli"].opt_prefix}
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
