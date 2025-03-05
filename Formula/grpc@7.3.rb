# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.70.0.tgz"
  sha256 "11336d7bc4465148db506348006dd5559ce478eee4bf1b080bb31b89de6974b7"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "88d31f057586297671af88dd2b36b47d409473e7b5f45d2d38119a945e3535f7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "33226c3e6ba3f485e2877e5887b7d4c9fc765669036af3f0820802ef91d5432c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ece7aa0af56b15790c4e05fc9f53b911c430404c686278c16b6c60359098fb23"
    sha256 cellar: :any_skip_relocation, ventura:       "eacec3749289c786e53ebb6ea101cba28db2d40690d2f957b183e1915a98d683"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1e83af14cd1220e06b912be78af5b7e6ce3c164e334b280e3122c3c64b5301d0"
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
