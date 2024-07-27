# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.2.tgz"
  sha256 "5efbfd399f3be464e293bb0ec4a773fae9bb4a43b67362e1fac72bb4cae4bbc3"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "bd229c8ac8a40e4782ccb62fe5b2aec4be1d3b226d6f6e1365aaa75688d14612"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "1486adb5bf9a7bd3af5f624412281b3dcadef2a921df967b48db86539d8ca458"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9b670564163d5ab1199d904a2abed8aeb85f4765419c8cdb55e69c795cd7a47d"
    sha256 cellar: :any_skip_relocation, ventura:        "d0c699a8f0494ae0e1dc3e862dfa31c942b758c92faf7e9fba71af4667ed625c"
    sha256 cellar: :any_skip_relocation, monterey:       "a49b3239854fd9c82d06bc145250f29a4e0e9dc83184a33519a4774e227a377e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "020d5919f95d96565e28063a430d965645c1c3cf9ddaa5c744e83786c9aa61c0"
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
