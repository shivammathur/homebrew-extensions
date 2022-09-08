# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.1.tgz"
  sha256 "74e22f8eaf833e605e72ef77df3d432bc6d99647df532d972f161874053859e0"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e2c188667cd7b6e98197d214c43e9634d0ef173fdb83256060e86f6619e275d0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5d7e37c3aada3853b416f749aa2a50fc1f780cb5b52415aa2d0c5973a88f930e"
    sha256 cellar: :any_skip_relocation, monterey:       "26cb27ccfa388434dee118fb636d82e6eb76bba9fbf04076a70c4e5709bc0ddd"
    sha256 cellar: :any_skip_relocation, big_sur:        "e546e12172867b94c2b51d01e2b8de6482d29ae0fbcfac4d0b67235f931fd324"
    sha256 cellar: :any_skip_relocation, catalina:       "cb9456588c634dd4db6048c1f2e805bd6f05baa35724f396e48f472cb04bc893"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "082618aff77e9afb47d9aa09ad1de07985e6c2cffba74945f2a689b954aa595c"
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
