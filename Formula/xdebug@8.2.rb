# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.5.0.tar.gz"
  sha256 "b10d27bc09f242004474f4cdb3736a27b0dae3f41a9bc92259493fc019f97d10"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "d94040c22c52a65531d63404b71e2c19c7e810b0b330fd19d1b6cfec2942d282"
    sha256                               arm64_sequoia: "8aae1d8f43ff7598510832012209bc581ca58278b87ce37939c9f70c6cf81d29"
    sha256                               arm64_sonoma:  "5f6d869f2c51b2c88b1fdf8f9d56d5aac58e535e520a9d3469dd01af2a3cec79"
    sha256 cellar: :any_skip_relocation, sonoma:        "b4c5a951d1604a18ca793d4989861313d753ff9936eaf4afcbb74dbd1870a228"
    sha256                               arm64_linux:   "2f3494581a7bf7bc4050580c41b2d7104f1d89871b728683bd99af4ae6cae941"
    sha256                               x86_64_linux:  "4d6c1a686cf03c3b60e9e999b38da8ea07dfe924ab5ba277d81610aa882ba2a3"
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
