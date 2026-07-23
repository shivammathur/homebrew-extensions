# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.83.0.tgz"
  sha256 "b12c7e0e048df728a4f2c513aeaa78ae18ad5c3ab3b607eeae398e0e1bab12ea"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bf17a2185ae8874e751d320ea10280f985bf0c6dad1ec93e43b590d291f86f51"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bb58c3170a96830b4ecbefb8d2b886196812f09968100b311eec39491d2f93a9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2ccd2a7f189f1c16c77832a5a3e0c66c5c6f916694bed62354bab86ba73387e8"
    sha256 cellar: :any_skip_relocation, sonoma:        "5575daaacab482008684149c13b994e3ba01dd84289648aca671ffba0b49e12e"
    sha256 cellar: :any,                 arm64_linux:   "d70ba382fef7c4eb7646de90c04e0152d7273bbd056d79e933111776a4f9e6d4"
    sha256 cellar: :any,                 x86_64_linux:  "b8a7852e4e8e6836ad5d170e619d466b03947e7d597a17a1d6acc540c9b815dd"
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
