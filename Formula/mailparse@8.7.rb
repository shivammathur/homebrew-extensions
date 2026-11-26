# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT87 < AbstractPhpExtension
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
    manifest_sha256 "0b2dba44d2efefbe74048752d0fd78a642328f895874cb775535f51d3ed08d87"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "5591fbdfd024c20f8b426dbeedefed896f6af43b96aaa0a033408bb90b398e23"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "bfa21a82d579bbca3a218c5f35edaafe93e997f07c60424fbd37fe7a999e120f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "9c12f662998f6f2d422ffdab8761ac791e1e106ebb61a9765b712680eecfc9aa"
    sha256 cellar: :any,                 arm64_linux:       "b9e7ff40417931919573d05238256b5d2b9eb801fc8b576402d1c113087aaa7d"
    sha256 cellar: :any,                 x86_64_linux:      "1278ee67526aabaee01666dc0bb467fe77510f2d09853a8655ba4e9a15758633"
  end

  depends_on "re2c" => :build

  def install
    # Work around configure issues with Xcode 16
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
