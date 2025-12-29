# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for ScalarObjects Extension
class ScalarObjectsAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bd86a3c6411cab459e2b5c9c6c108fdc1fd31e5b816565cb435d381864e69624"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f6ba63d5b9e3604bc29170d885f4d133ac4e457727d794fb4e93988fc3b66c5b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "971ae6eae35f363ec4977db09082402d221ce2bb203070273fd6a39bfaa3cd94"
    sha256 cellar: :any_skip_relocation, sonoma:        "1dc469d1c7f4a428dc2d9a2736a60be12afc82532ef3c55d09242c882435d661"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "dc41a0444f3bb6d2986fefa315f3cf1277ac4ac6e1183784f61c9943bb79695b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a6484f6745b357eeed53a4cc588faa5f3ec2c5c47f75ef2b76804ff15083ec9d"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
