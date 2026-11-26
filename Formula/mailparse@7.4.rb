# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT74 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.2.1.tgz"
  sha256 "a9f092ae84f32f15149a09a9a278bb20d3794cbfb57893eab4933814d7ab2fd5"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "19b7b53ce38e2d350b099b7a5bd97e4a2ad529e02ec5a1564666fcffa955af5f"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "f86d90bbfdf7490b555f1fa4bb852407e76ec3614dcfad31a8bc1d6e3fb8feb8"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "23a1a55e46009e795dd14adcfd868b00f57a5bd8ca6eb5642722480d58900a84"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "b83c123230e988d6a60352e369ccb7a1b35ec66b21d3a8d0d35c139e528f4dad"
    sha256 cellar: :any,                 arm64_linux:       "c217743c192ded0d7842489663459bb6f566ede768a257ec672618fb4eb9735c"
    sha256 cellar: :any,                 x86_64_linux:      "535878bc6f383742aef316e40fa98b0a9b05514f456628dece0af3480e8f1e92"
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
