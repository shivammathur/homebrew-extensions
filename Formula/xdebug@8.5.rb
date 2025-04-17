# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/02e76b49201a349b559a3256b19d1d388461978f.tar.gz"
  sha256 "f460c832048222b76e77eb5827c673c6153b555582483fbd597825025990d907"
  version "3.4.1"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 arm64_sequoia: "f6d9efb7959afd53a1971525616b82ab22c87d348429722c6fa505890c08d2a9"
    sha256 arm64_sonoma:  "e874da5a755ae747215f10c3fd01cc45902cd5eabb85a432b12405fd5ff58f18"
    sha256 arm64_ventura: "20bd1baac836867d262d0109a72ef6aeb09b28a472e65a161d780d9e04d53d58"
    sha256 ventura:       "f14b35a68c5f9d98b908807782f7d064e0fc66ef0a829d918ed179bb45f37b05"
    sha256 x86_64_linux:  "ecabe6d0c4c4a316e94105a94dddc7e20d74b455d0dac4f1ec692c4f4c9904b3"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
