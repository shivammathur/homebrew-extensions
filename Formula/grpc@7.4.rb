# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.66.0.tgz"
  sha256 "6f6b751bbf33a88f917ca11a5b32923223c106eb5f064b791f99c6f7a9c7e7c2"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "8c8248daae096b756e319fe69302eeef582c7dc0ed3c906ffc1548701cf7469b"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "80a6bc954ad3b640d274d4033534df11eaf48ee1f6be7e4c782e07affe3cec27"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f5f9e3056a1b5dbec1cedbc2bd8f99155971638a694fd2e88a2a97a30c8b6fb5"
    sha256 cellar: :any_skip_relocation, ventura:        "39d6c43b69f69ee1b4310466853ed080c0c02d4c34073f54239315ad44a5466f"
    sha256 cellar: :any_skip_relocation, monterey:       "847d8fc098f8dad0bcc5c126ec289cc06c7e305426048568237f9dcfa26c53ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8ee3c85dc40a42acf19fb4027fe99c6aa89a8c417b30b7eba10763b21f778df8"
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
