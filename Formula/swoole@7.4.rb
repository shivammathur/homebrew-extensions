# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.7.1.tar.gz"
  sha256 "0fc700c8ea65ecf5247c7394a49b1f211e4a419987dd50adc0b0eda4ae1523c5"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "6149ed2bb666a58c6ba57e8fe7eac9890e5855e222a9814245160a25c6d09990"
    sha256 cellar: :any,                 big_sur:       "915db1a69260dda597287d976c7b7d756bcc5c49dcd1b9353611621a34d79880"
    sha256 cellar: :any,                 catalina:      "4e1504c7646791637d8a3bd7ed26b22d7191b6968d7f8f3c194a36df4690f8fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "96345fa4143245766b4d4dd33e39ab4375b2aca5951df1d98a145aea66b0d211"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
