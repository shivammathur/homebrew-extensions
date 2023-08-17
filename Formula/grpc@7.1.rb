# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.57.0.tgz"
  sha256 "b1ae19706fd3968584ed3079986b4cf1d6e557fc336761a336d73a435b9a7e60"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8d19cfbfaba9e3900b90dcd7894f4c20a767e23dc152c4f35797e3514b282044"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d1384ba5cfd0211036380e7c674b44ba8c8c3d848b2763c696e615fb7815f1bd"
    sha256 cellar: :any_skip_relocation, ventura:        "7e58c8a8cd1f718d54d7176517afdfebedb88b51038efd80075c184fbc7b53eb"
    sha256 cellar: :any_skip_relocation, monterey:       "7354979466659cc7ce8e1520ca5ac4fe2e858590208e47229557ca472a5fccc6"
    sha256 cellar: :any_skip_relocation, big_sur:        "b8127dd591ad69f364f33c62bf8317757cb6358658d1993c956c710a5496e967"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "21269ce5bb1157a5a6f5d35145a043c43430706d2cbfd8cedddd914536f13ba8"
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
