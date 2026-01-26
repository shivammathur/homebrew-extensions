# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT56 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.14.2.tgz"
  sha256 "db02e9106355f9a29f2ee75e31e4cc808fdcb69105ccdfbec4640f994a5f0a08"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "ef3784dee0c546864d8fb2cae81252b3b4979fb382654e6612c16c6950213167"
    sha256 cellar: :any,                 arm64_sequoia: "50642717c6ac7a6210463f10196fb8b1db40034dc5b27f7aca34585520cec71f"
    sha256 cellar: :any,                 arm64_sonoma:  "8dc82e770c77e45df062a7cd7f5de2eafada0be519f1c2eb82269ed7bed944bb"
    sha256 cellar: :any,                 sonoma:        "cc2f610b857adcfb4e709ca957e50aee6a4bc41fc1d12d3e3951e374eb354c7d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7f45dc50e989fc36113acf25b5381b726a21c6047ca06f9792bfb725f8504e5b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "15ac0f0dc75e719005fa2998d7d57c5b39364d6f1f53d3e079388ef90d5f1ad4"
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
