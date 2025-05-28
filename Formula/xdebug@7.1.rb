# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT71 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/2.9.8.tar.gz"
  sha256 "28f8de8e6491f51ac9f551a221275360458a01c7690c42b23b9a0d2e6429eff4"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "0145965c8be563d709175b1b4f5c9521fd11b0be64a35d40827a43fe2aca62e6"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f2c7a1031b8e9d0c2caebcf37c370a34185e6f87a5dc5e6f054d22ecbe32dac6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e5075432964bed41bcbdf45419842173f8177fda94027d45e880ae2e5edbde93"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4fa906e4e575df3df5ecbdf76854c388817ad014689927ee6b202e102cb5efe1"
    sha256 cellar: :any_skip_relocation, ventura:        "c4bb38b1dc9563e610f766f43a02ac9becd07bdeb42c9b8248780c27811b3506"
    sha256 cellar: :any_skip_relocation, big_sur:        "a47a76c5abceaf29d9ce37ca5a5cd299dd604649517a894e885486789f2b7b75"
    sha256 cellar: :any_skip_relocation, catalina:       "6bbd0da640e9b1060634f15909ae53804efb34afdce1fcb0793cbf7bc7f2fcb3"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "f7e21b2e110fdc1d422a2702b1dd0ba2761583fc2d37c4d0bf3d10b09dca38f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cb170710c047d6c05d159cd08769bbd422789ee1cf0d838791f14b878e6d7d44"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
