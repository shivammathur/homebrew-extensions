# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT86 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.2.0.tgz"
  sha256 "cc5111ae17bfa36efcc5ef23dcf75b6501593ac264c196aad3e39cd4ad765332"
  revision 1
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "0334b7038f8d63372295c62c251e85cae3c9d86902dd19f7c33315d59dc04b1e"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "1d1c8a6e38e79698acb082cd562b6a5501d4c4c13ff2ae08dcf1f3d5442f09fe"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "dffaacc4bd3c45dde2fe20e0234b515c31d0088aad7d8054325ca6368f3e43d2"
    sha256 cellar: :any,                 arm64_linux:       "93f6978ed1439ecd87f4f071545d8c26434412916e2a052e9bdf7be3979c3237"
    sha256 cellar: :any,                 x86_64_linux:      "24f37dc206b3ff3e35bee0a72f4c246f84f382de719add56632f0cff1e088443"
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
