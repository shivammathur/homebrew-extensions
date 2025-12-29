# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for ScalarObjects Extension
class ScalarObjectsAT80 < AbstractPhpExtension
  init
  desc "Scalar objects PHP extension"
  homepage "https://github.com/nikic/scalar_objects"
  url "https://github.com/nikic/scalar_objects/archive/86dbcc0c939732faac93e3c5ea233205df142bf0.tar.gz"
  sha256 "a0f621772b37a9d15326f40cc9a28051504d9432ba089a734c1803f8081b0b39"
  version "86dbcc0c939732faac93e3c5ea233205df142bf0"
  head "https://github.com/nikic/scalar_objects.git", branch: "master"
  license "MIT"

  livecheck do
    skip "No tagged releases; using latest commit"
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5dcb31562ce8c70569bb8a3818b42eefe07f6a2c9b508e649244ed840c2a6a75"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "79c4aa6c3fa551ce2e4baf360180d3eddfa70fd1e0362861d4e3a4784f748ab1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "982cc69ad42c8dd906593476955a790ea04c7d403eb46f5dfa02cc0d851f3220"
    sha256 cellar: :any_skip_relocation, sonoma:        "8e53efc5cd1de7c2470da0b134c3fe1f94d0d204d818ea2e5b7739995fb7b9fc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ab3ff79c0fe82b18ccaed184af63394ccea94308d684a3e07b1a5e5b84f59e37"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "31d22761414b24510f801ceb49771636b0eee1fea51129758b9f353a682aa154"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
