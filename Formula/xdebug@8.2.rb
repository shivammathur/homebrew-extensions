# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.5.3.tar.gz"
  sha256 "954e56021668121ecc50b92d2ad1ce945f22ecf81ffc5bb5835219485b12ef5f"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "8cd105d0d0e0130abf7f779a3863d1254ca12c278f351deb0b9589f230cd80cf"
    sha256                               arm64_sequoia: "f32035d0a16c00b614f26481186bf06dfd388e17651ee6260891e6cfe4851bff"
    sha256                               arm64_sonoma:  "9f7142dd46a12d0f5599c3268c47053f6fe82bceb1d266284f7d3f2b233cdf7b"
    sha256 cellar: :any_skip_relocation, sonoma:        "796a4c7d44eb00e2564d9858abf5f494b9324e4b884fa207484e5e7dd2facec3"
    sha256                               arm64_linux:   "fd4f525f230fb76746e0a73d4d5f8f61ee3f18f291342db9098509d517b37e25"
    sha256                               x86_64_linux:  "9a48c422137df563ccb1f9b478b41f58d69f1c4c5e6bf652c14f07e11651bf9f"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
