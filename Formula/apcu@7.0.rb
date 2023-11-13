# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT70 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.22.tgz"
  sha256 "010a0d8fd112e1ed7a52a356191da3696a6b76319423f7b0dfdeaeeafcb41a1e"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "178a2bfa855ecf33a855d64895cd0013a0cd76a18717cb6c20f3e41d598e7636"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c958b62677d6108962ec9a8dc78d093ba0a32572df233a416aa0c62c0f2e006d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "009dcb9d7b683498eb9450a16ab6e71f34ad8750da8afa0adf4ed1ce3c7b60a0"
    sha256 cellar: :any_skip_relocation, ventura:        "f76d1bc01b59c552fad86f2e935a4d58cde916357051781d16997547ff1ebb1e"
    sha256 cellar: :any_skip_relocation, monterey:       "8fc953b71be3f62f1b9b5941c6e1ae0146be7aeffdc50c247455803802dd2219"
    sha256 cellar: :any_skip_relocation, big_sur:        "4d974c1b11d9c508add2534a1b22ed46db1f3c225ab3c87a48d4cf99abebe979"
    sha256 cellar: :any_skip_relocation, catalina:       "b32c88b213419dca8ecadb6bea7d66851c46f5cdf714742aee72584bb75021b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ac9623c43b4effa552b75a2ce14790e284a0cb214a49a9cb3265f1779e6f8b62"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
