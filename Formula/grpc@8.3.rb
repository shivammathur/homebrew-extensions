# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.49.0.tgz"
  sha256 "dfcd402553a53aac4894b65c77e452c55c93d2c785114b23c152d0c624edf2ec"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "609e788e89a9b0e226cbfe95f071529fe62a706551d89d8a480a532dd32d7d22"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1e5b6622b4ef15d45ce35efb498b7af73570715a7a9dfcc0b915be2ca409609d"
    sha256 cellar: :any_skip_relocation, monterey:       "c778e9755a488793c72dce664577aef575807acb59014158073be39277bf1ba7"
    sha256 cellar: :any_skip_relocation, big_sur:        "a4e510d31c31864ef6f67827b949ed0195c417419e2e97ad06ead2b123b00e89"
    sha256 cellar: :any_skip_relocation, catalina:       "e149536738db6509d67b7880a5a05dd7ac9a0795a4557610d772e6a4582c4d3c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "45d34687a8b6a20e28929d11c7a46ca9ffd8d22d3d423f8bc22d0867eed0f1df"
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
