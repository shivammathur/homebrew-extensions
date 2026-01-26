# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "b780c9d25f9b3332fd7e974f04e7df6ecc0b7bcb0a8067f60b57cee27a26ef66"
    sha256 cellar: :any,                 arm64_sequoia: "f4474d7f9fbcf638c8ed51f686872e22e97b22e626073b9bec1a050f5a370572"
    sha256 cellar: :any,                 arm64_sonoma:  "3dc064388615c12342d8c378cde293e4ac79d8d9e63a99feec282ee171cd7c52"
    sha256 cellar: :any,                 sonoma:        "35473f4d792311723809d7d4bcc7b06a691f298758165042045a6fdb2cfe3c27"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fc318d043c2943af24d7a549f47c4f4bc1d395465b6370a46fa4d67eeb9df9a6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b475af4f88097b240b26e856933891ad661e09305d99925b8f956e300a4a9615"
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
