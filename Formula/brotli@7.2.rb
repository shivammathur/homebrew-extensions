# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "76227621841eb21de82d86d4eef6ff24980cf3511f6f060e37183e7001ddf33f"
    sha256 cellar: :any,                 arm64_sequoia: "699fc16339a5bf5a75e56a4c5a00ff7f3100a51a7e4abaf0f4e092bddd22d710"
    sha256 cellar: :any,                 arm64_sonoma:  "b611cc29f0b8eb1d5431021605b7c82158a1224777075b9fe5a665211f037b27"
    sha256 cellar: :any,                 sonoma:        "b92f0fe9de51b0a0ef11cad081ae25e072e563ed254461993a75993917160712"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fba384b0cc3217da03e8c342b9c6f65b2694f06be5f960c7534b4083fd909ede"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8ca3557062b3aa7ce9002ce03605049e6980f3727213910893e4f982c41a2679"
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
