# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.6.tar.gz"
  sha256 "8cd397bda05da1f3a546a6c537b8896e668af1ae96af8b6c4b2bbf8af57c7dee"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "f951521215bbc1871061630f8fcc1f97e52eef685634c4ccaa899452d27cf974"
    sha256 cellar: :any, big_sur:       "5968d75706e5d70fd2878f6b1f710989b049f30ec3d638db1577fb6ed359b5bb"
    sha256 cellar: :any, catalina:      "84182d74956b3e9119a0c68b3bbbfd01e873d8cf466a022e320956bab11b8d16"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
