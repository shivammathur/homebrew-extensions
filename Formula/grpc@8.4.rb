# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "0ecbda5d7c83aae617fecc03d13571551112ac83abae82e9091f9ff83ff0a5e9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a13f60861ac6e0c839062430683a852f76dc8408f5511378d07560b94b0b8ed8"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "97b4b5779d056b06a1f05a25b8c0c366500b7deacd538313d038e2edf093cb10"
    sha256 cellar: :any_skip_relocation, ventura:        "9fcf8e26408f6dd8d1ebcf8859e9d1c110e89d144c560d78b4607e233bae7947"
    sha256 cellar: :any_skip_relocation, monterey:       "94de1f0d4a001acaed7256049da829fa4dc2daddb498fec1c6d510f51ac7fb6c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eba83ffaa59621365de5b3af3f9004ac17f42d24c4abdfd38646732bca086601"
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
