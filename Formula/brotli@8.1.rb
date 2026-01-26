# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "123427d0fca6ad3f58a48477e01fb002db8b00a3b08aafc456756fae7b156953"
    sha256 cellar: :any,                 arm64_sequoia: "4a4922060d675733efe8cf4c02843d84c73a30dca984f3ea4c4cf058baaa5be2"
    sha256 cellar: :any,                 arm64_sonoma:  "5914c8fc7f14b3e10a736a2d5b8214da38efc7c19d627c84701691b98c391989"
    sha256 cellar: :any,                 sonoma:        "478ca768e4a374389d04d9c4ebec205c51c1f864420d7f584d27ed601385cf6e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2b989e5228ceaadacd85d4fc112b455a12bf8ec7336fb93d6948a493bc455e76"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "790a64b250bc9b91c2e27c01b9e8112c9a2517fa9a147dfa7465d1067a3293b5"
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
