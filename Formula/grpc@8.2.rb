# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.55.0.tgz"
  sha256 "75f9a465a4d1f6f337aa5dd83e5b5447064aa0a2b2776a72ec192ad7972c8295"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "efa93dff660e0046852354c27e2c22422b2d311a00971a76ef4bb5b300a527a5"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "48ca49fffc5566c86fec280ee58e4806c6126b5c5852af923f1fd407908a9c87"
    sha256 cellar: :any_skip_relocation, ventura:        "c52960da58ef8727f4f40a5aa60643d4bb0772862d0caeb06bc8101747dc29ec"
    sha256 cellar: :any_skip_relocation, monterey:       "1ac3fc625ac52e1913e7c62e93f15d464c21aa8ac4d679eb22da5ded666399a8"
    sha256 cellar: :any_skip_relocation, big_sur:        "3ff355306daaf46eff24dfcbf8d9dfd1eeadcbde33847df4a0dbb1bf32eb5e80"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "80f3eb0954bc67b521721c90fd5136396ce3991543506c51974949fe57aaceab"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
