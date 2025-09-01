# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT73 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.2.tgz"
  sha256 "fd8d3fbf7344854feb169cf3f1e6698ed22825d35a3a5229fe320c8053306eaf"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "c57897bcbfd2f669d594ff31c206a89a98b669133c5f173e01e7f686edf6547c"
    sha256 cellar: :any,                 arm64_sonoma:  "59c47c4c4857cf0428800500014d23e72f8eb77357682061a0db0117991449a4"
    sha256 cellar: :any,                 arm64_ventura: "a3b7ab5dd8cf8c7a3ea20f2f40ea2b526e9d053f40298e48a28f064df476d835"
    sha256 cellar: :any,                 ventura:       "fb4eddbf7d5a4546f95b6317d7f7acfa6d4011fad7429518b59073c8648d5cca"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "de94688fc1e1f34beb6b948b22fe7667a06940bad4ba5146e7d53a4d1f6047b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "87be4bac1254c4ddf836bb32d4bc53d01bf953fc932af3f6561f7730eff6470f"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
