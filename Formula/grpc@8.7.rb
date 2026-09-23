# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT87 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.84.0.tgz"
  sha256 "555716233a5cc9a6baa605719f87b7688a88fb8bfdd9b4493396276244d56625"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "29d1ad1fa0453cb0bacb8a62b511c3413cd2a8c0f13938db09fafeb2325955ad"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "c18cbbfc6f75147737a5088477c1851306aabc6c7d4fa5e5927a0b87e2635d39"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "326eb4e97d5e2564671a1b9cb527a565d1be31d2a9e4499acb6e441a6ae712a1"
    sha256 cellar: :any,                 arm64_linux:       "ea9d1d8ca8a08d8b1096267952707bc3c27ed780109541a3ca160745af56bbca"
    sha256 cellar: :any,                 x86_64_linux:      "80b0270c8aea8e50cc957068f8329a97f0a2e147953ba76e7ce145e99ee3b6ef"
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
