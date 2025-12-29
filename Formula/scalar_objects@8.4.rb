# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for ScalarObjects Extension
class ScalarObjectsAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7ef9fbd87eb38c8e45a910baef153e7b6943428d6da426a87d723e6ffdd97ffd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b51296d5735b4a98cbe74663fcacbaccf069db2ca3252246814778332613375f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4d537cdfa52e0711195b5a775e1fc6a9033855f8969f6a70468bf1d964043a57"
    sha256 cellar: :any_skip_relocation, sonoma:        "8a02d8084df640e8acd1fc1b3493c9ccc184980857ccebd43e3d32e8229a74b2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2fe914bef1ff4673a01d91e10cd55d1f36b27ae78f9bce5980182493b8dec9dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "881c4dea3762656b891f87ce46f2b95d00685e97922fcaa336422494176820bf"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
