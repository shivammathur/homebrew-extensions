# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.52.1.tgz"
  sha256 "f8ce3ec8ab3678c70d57fe60982dcb6562a6cc162718cfbe74783915b49803c4"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b882819eed60f3de564cffa67f844159b3d572127d75a7f81789b5d7b1414a63"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e32cf68cf5c0799adbee1699c7385c67ddc164adf5e2b158f9051fffbc558599"
    sha256 cellar: :any_skip_relocation, monterey:       "85c65db2dc8ea86831bfee7e31458da78b344f9e7a2371e587b61d6712a04604"
    sha256 cellar: :any_skip_relocation, big_sur:        "597a55c8656df10e51b195063aad8c5b8d68c6e1a35244c091b7c61e7c49a76c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b5732fba26b85ada5397f84a3293a7a69ddcbad449ebaa500de007503f3d2413"
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
