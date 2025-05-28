# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT56 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-2.1.6.tgz"
  sha256 "73705197d2b2ee782efa5477eb2a21432f592c2cb05a72c3a037bbe39e02b5cc"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "d9913ee96702f96f0fac22681c3a245bf1268d1984b8d2ba308a96b6f7a57a77"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6892292f9749b1db05a234d2cf23755dc10d1d96683ccab8fa8f089d7db00ff8"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "04dcd5ebfbb302f74904effebbd5ac0ea429ff17fff1edc2be696d9dd24b9dad"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3502ce17256db8ab5e271861530bbd3533fd853b120c00ff7b4cb43ed4bf2ca4"
    sha256 cellar: :any_skip_relocation, ventura:        "d6e907ec7f44ef3d002c1295835cdfbbed1085c94c7c41adf4b3a905c0d5b16b"
    sha256 cellar: :any_skip_relocation, big_sur:        "2cf4ff3f590153e6e3305424b7054e1ea7b6bf111c7acdb48472cf5f17a46a17"
    sha256 cellar: :any_skip_relocation, catalina:       "1f3d1ef9cdb318ea53c9334e285771d3eb594472a938fa95dd51b0d1e5f74ec2"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "f7e856e9c8ea42b64a5f29487e88ce34285d9537e3a630c7ee72f451abf879eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0de6c5ff5a74c3cf410264432b7cdb8a8746cea84fbdc9c13394d8e61fd0c97e"
  end

  def install
    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
