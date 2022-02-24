# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.44.0.tgz"
  sha256 "f6d6be7e1bd49b3aae7ada97233fe68172100a71a23e5039acb2c0c1b87e4f11"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d808273ae45e4a8c1cf5e03a48e4b9cddb815e9b3fe7766d2f4711793ca18d1f"
    sha256 cellar: :any_skip_relocation, big_sur:       "ea40e8c560f6f346e12dbefbbcdb046f276931977b1e43cc03473422fcb4b260"
    sha256 cellar: :any_skip_relocation, catalina:      "a04b09dffcbeafdd952469d98941cef2a185e940851cd0eea26abbeaa10a3b83"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a96be486bc481afcf51520c0459cd58f9e8087ba608332a6a59c9049a40e70e9"
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
