# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for ScalarObjects Extension
class ScalarObjectsAT86 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "87549339a726fd2c8c0acf36616657dde2eff10c3abc851a98c5de3021f30f94"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c57e6b6ff37faf1a9803780b8b6e56c3247dd6f1c5969b8ea000eb60d7bdaf44"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "217e810e438183552a49086412adaa645c5b1f91aa5e9a437ab6217abb6ad25f"
    sha256 cellar: :any_skip_relocation, sonoma:        "bb1f26639ef36d251dccbb32e0ac856b7040b60d6c98a0fa457b4ad1d2f6db70"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "93aaa20f6b979c4aa2a771379784e5075e35476af3c223c2dabec7706e157d92"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f60baa88cb830a50a00451428516d057685bdc6a9b7e1764dd8002b3fb72203b"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
