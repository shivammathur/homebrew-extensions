# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT70 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.2.tgz"
  sha256 "7e782fbe7b7de2b5f1c43f49d9eb8c427649b547573564c78baaf2b8f8160ef4"
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/raphf/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f3a4f46461da3108608ffccd5b7d6dc67baaf0d924670ad6b3c72c4a56473aae"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ebf9268462561122b318261e982d1ba5939bd918074673e264d9444696e0f099"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "910274f5f104b612fcefa025827184d00d7c596964ec81af8a48ee248e52e51f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a05239755055002920a7b9ed2b02fd07374d92da6b21bb5720b39c4e5d92585c"
    sha256 cellar: :any_skip_relocation, sonoma:        "83c62e2a1057eac32b63e2098ff15a0e880b5c1fbfadd9abc47b260ef0fe4be6"
    sha256 cellar: :any_skip_relocation, ventura:       "0ef29e8e685bed51afeec71e85c042cca58e201e96ef689303ec3cbf842a1655"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6b1796cdf4de960739a5a477bb1eb94f51ae0856c74ed33a4e84296722d4458b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "17359c893db50ee7c7bfb52848961c8817ae6761ba52ffc6b61b16a947b72382"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
