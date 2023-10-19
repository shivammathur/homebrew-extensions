# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.59.1.tgz"
  sha256 "d789aab7c791647907c3bc3af2bd6b6e97348d1b50eaa59826be61c4a3c3d3ee"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "837b9fe63a8d5dad5ff8fbfee9da31dd15d261bfcb5355613e95a1a162f7adf0"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7a51ebbece5a1cdee60e940a24fb1e26c6e029df12504abb79005ba5fde3d3aa"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2b577224b9948246e68dcb68a6aa5410fbc1ae9a060b93b5f45cdb74c54edaf5"
    sha256 cellar: :any_skip_relocation, ventura:        "afa329528b9aece472981d3d645db4fd434df504bf6755ecd067cb8431799fd0"
    sha256 cellar: :any_skip_relocation, monterey:       "b8d65c115785fd8411d8b4cb62b646d00b8b60a8f4a56812cbbc574b62d7b834"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e81bc6f9914cd00b67d05fe5a4d7b2854060a4d28fd047bc2428b785e2f38cb5"
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
