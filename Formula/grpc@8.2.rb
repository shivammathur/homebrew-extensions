# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.70.0.tgz"
  sha256 "11336d7bc4465148db506348006dd5559ce478eee4bf1b080bb31b89de6974b7"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cf7a55bcb2ff89d986cb8846c84670e6a636a36b202e15a364946d735fa8647d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bfe72ae9cf1956652328f0898ec2e3e30033259cb9accf01925c9640e4a115e6"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "89745b619180aff287c1c57e3f799df686c2b19c61ada199e2f87425c7cc2a13"
    sha256 cellar: :any_skip_relocation, ventura:       "1bbcdecd7c6eb1b0288cae4ea9903ac0080302939f1fce1e89896ffcc77e6f37"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ae4371ecc99bf72e78b56bb01dbc82eabc64e76e0b96123f47c7063aa05eeae7"
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
