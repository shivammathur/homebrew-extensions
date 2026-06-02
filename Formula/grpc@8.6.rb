# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT86 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.81.0.tgz"
  sha256 "3eae67ce7c8f5e861a9b5472542c541e094bf964f3651f4ef015487640afcdca"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f9b357efb3350a00d260a1dc1a3ddb068d9fb57ea5b1eecbcc047d05f97811ef"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "70086dfd1d4b5ca27d3a7adba7a39d8ae762d0fc9e28deed76d3f0eee661f8a7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0430a1bac6179e2f065ab95dcd9ea66518d3e2dda69a602e99cde2816571a54f"
    sha256 cellar: :any_skip_relocation, sonoma:        "22418cd19805a197a32076e20535761dc2061bc64a539f65d1a580a514fadb86"
    sha256 cellar: :any,                 arm64_linux:   "34a311a49b16568e6fe9a31d2363f3522dfd64ae3aaef59627d868d0eda16579"
    sha256 cellar: :any,                 x86_64_linux:  "9701289ba92386d024d7a8d0c3910215a8cb46098dc036b66a7e7e1500d0d28f"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    inreplace "src/php/ext/grpc/call.c", "zend_exception_get_default(TSRMLS_C)", "zend_ce_exception"
    promise_factory = "src/core/lib/promise/detail/promise_factory.h"
    if File.read(promise_factory).include?("GPR_ATTRIBUTE_ALWAYS_INLINE_FUNCTION\n    absl::enable_if_t")
      inreplace promise_factory do |s|
        s.gsub! "GPR_ATTRIBUTE_ALWAYS_INLINE_FUNCTION\n    absl::enable_if_t",
                "GPR_ATTRIBUTE_ALWAYS_INLINE_FUNCTION inline\n    absl::enable_if_t"
      end
    end
    inreplace "src/core/lib/promise/try_seq.h" do |s|
      s.gsub! "GPR_ATTRIBUTE_ALWAYS_INLINE_FUNCTION auto TrySeq",
              "GPR_ATTRIBUTE_ALWAYS_INLINE_FUNCTION inline auto TrySeq"
    end
    loop_h = "src/core/lib/promise/loop.h"
    if File.read(loop_h).include?("GPR_NO_UNIQUE_ADDRESS union {")
      inreplace loop_h, "GPR_NO_UNIQUE_ADDRESS union {", "union {"
    end
    inreplace %w[
      src/php/ext/grpc/call.h
      src/php/ext/grpc/call_credentials.h
      src/php/ext/grpc/channel.h
      src/php/ext/grpc/channel_credentials.h
      src/php/ext/grpc/php7_wrapper.h
      src/php/ext/grpc/server.h
      src/php/ext/grpc/server_credentials.h
      src/php/ext/grpc/timeval.h
    ], "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
