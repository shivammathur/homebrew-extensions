# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.69.0.tgz"
  sha256 "85ef59edd3517b377736c49a73799ead4729a82b960474b8842c9f89d2fbf222"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "41292358cc1ddc5d62c5de166ef51488d73cbcfc7f67846cdcf34ad50d10ea40"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f852e336b2a1cf6ce7e84ebda3452af15a65fb275f924f4ccb1b66f40172ffd8"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1307c4463a4ab757dd7dace2a3805846eb82ed4121d05472ad4060b7e0178749"
    sha256 cellar: :any_skip_relocation, ventura:       "08a748e2a6471a9eb0669c19b996402c3cd6f89e609cdbc14656d220aa901bb0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "01b70123b6218984be1301ae7cbb90aa3c38df68030ea37a879e8cd274ab674a"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
