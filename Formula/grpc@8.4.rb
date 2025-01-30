# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.69.0.tgz"
  sha256 "85ef59edd3517b377736c49a73799ead4729a82b960474b8842c9f89d2fbf222"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3726bbd97e2a30b7cb9fd0fa462a5b80378f043d261d5d00bd6733bdd6951c97"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7056c09b53676381bc5bc6c8333ad71da142446f218dd8bafae944e34df0dc86"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f452ed8b6964cfd78cb3d0f263183d59d17a62d20bd0db1ac3cf55b22d25a5e3"
    sha256 cellar: :any_skip_relocation, ventura:       "2cfee84943fcaa5be0fe5f05e4dce0c064cb49e8ed18ed7c2b87e947563d3c2f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5a2ea808395809d10f934d896c74558fb99f7f151817beccf0bd7c9eadd6f78e"
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
