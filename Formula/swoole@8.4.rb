# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.2.tar.gz"
  sha256 "89d88ef2f7dfca96d4ff74febc62ec78ccbf92996176107cf30d538b30dee1ba"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "b8bef802539020bb9047c7847844337c8e95112e5c7d2b063032689a238b710f"
    sha256 cellar: :any,                 arm64_ventura:  "02c52164080a728f1ffd77a030d875c7ca90f81fb7f699386f6c7c7a90a64343"
    sha256 cellar: :any,                 arm64_monterey: "dfadcc0756630ac21fc512c48dfadf9071af906347f69c64a443ac5271e03b45"
    sha256 cellar: :any,                 ventura:        "c081e2da5af554cb4e2ac76144bb40aae692c8c4b06fea015b91dd9ea6133573"
    sha256 cellar: :any,                 monterey:       "f17009de80f1ad1c7e835661f5b396e463adaa6968879eb11697d9c483f33423"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "849fa5f14404449b9e63f24023eaf2bede339078f7d250cf68339c9a2f70be9f"
  end

  depends_on "brotli"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
      --enable-swoole-curl
      --enable-http2
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --with-brotli-dir=#{Formula["brotli"].opt_prefix}
    ]
    inreplace "ext-src/php_swoole_private.h", "0, NULL, 0, ", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
